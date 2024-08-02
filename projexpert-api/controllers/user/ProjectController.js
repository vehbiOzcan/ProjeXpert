import CustomError from "../../helpers/Error/CustomError.js";
import asyncErrorWrapper from "../../helpers/Error/asyncErrorWrapper.js";
import { AIPrompts } from "../../helpers/ai/prompts.js";
import Project from "../../models/Project.js";
import { GoogleGenerativeAI } from "@google/generative-ai";

const addProject = asyncErrorWrapper(async (req, res, next) => {
    const id = req.user.id;
    const data = req.body;
    const name = req.user.name;
    console.log(data)
    const project = await Project.create({ ...data, projectOwner: id })
    let datas = { ownerName: name, ...project._doc }
    res.status(200).json({
        success: true,
        data: datas
    })
})

const getProjects = asyncErrorWrapper(async (req, res, next) => {
    const id = req.user.id;
    const project = await Project.find({ projectOwner: id });

    return res.status(200).json({
        success: true,
        data: project
    })
})

const getAllProjects = asyncErrorWrapper(async (req, res, next) => {
    //const { id } = req.params;

    const project = await Project.find();

    return res.status(200).json({
        success: true,
        data: project
    })
})

const editProject = asyncErrorWrapper(async (req, res, next) => {
    const uid = req.user.id;
    const { id } = req.params
    const editData = req.body;

    const project = await Project.findByIdAndUpdate(id, editData, {
        new: true,
        runValidators: true
    })

    res.status(200).json({
        success: true,
        data: project
    })
})

const deleteProject = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params

    const project = await Project.findByIdAndRemove(id)

    res.status(200).json({
        success: true,
        message: "Delete Project Successfull"
    })
})

const projectDetail = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params
    const name = req.user.name
    const project = await Project.findById(id)
    let datas = { ownerName: name, ...project._doc }
    if (!project) {
        return next(new CustomError("There is no project with this id", 404))
    }
    //console.log(datas)
    res.status(200).json({
        success: true,
        data: datas
    })
})

const projectDetailFromProjectNo = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params

    const project = await Project.findOne({ projectNo: id })

    if (!project) {
        return next(new CustomError("There is no project with this id", 404))
    }

    res.status(200).json({
        success: true,
        data: project
    })
})

const ownerProject = asyncErrorWrapper(async (req, res, next) => {
    const id = req.user.id;

    const projects = await Project.find({ projectOwner: id })

    res.status(200).json({
        success: true,
        data: projects
    })
})


const saveDoc = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params
    const doc = req.body;
    const name = req.user.name
    const project = await Project.findById(id);
    
    project.projectDocs.push(doc);

    await project.save();
    
    let datas = { ownerName: name, ...project._doc }
    res.status(200).json({
        success: true,
        data: datas

    })
})
const createDoc = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params
    const doc = req.body;
    let prompt = "";
    const genAI = new GoogleGenerativeAI(process.env.API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    
    if(doc.docType == "PID"){
        prompt = AIPrompts.PID + AIPrompts.Transkript;
    } 
    if(doc.docType == "OKR"){
        prompt = AIPrompts.OKR + AIPrompts.Transkript;
    }
    if(doc.docType == "SPRINT"){
        prompt = AIPrompts.SPRINT + AIPrompts.Transkript;
    }
    

    const result = await model.generateContent(prompt);
    
    //console.log(result.response.text());
    const data = result.response.text().toString();

    res.status(200).json({
        success: true,
        data: data

    })
})

const deleteDoc = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params
    const project = await Project.findById(id);

    let index = project.projectDocs.indexOf(id);
    project.projectDocs.splice(index, 1);

    await project.save();

    res.json({
        success: true,
        data: project
    })
})



const ProjectController = { addProject: addProject, editProject: editProject, deleteProject: deleteProject, projectDetail: projectDetail, ownerProject: ownerProject, projectDetailFromProjectNo: projectDetailFromProjectNo, getProjects, getAllProjects, createDoc, saveDoc: saveDoc, deleteDoc }
export default ProjectController;