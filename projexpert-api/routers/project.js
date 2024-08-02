import express from 'express'
import ProjectController from '../controllers/user/ProjectController.js';
import { getAccessToRoute} from '../middleware/auth/auth.js';
import { checkPersonalExist } from '../middleware/database/databaseCheckUser.js';

const project = express.Router()

project.get("/owner",getAccessToRoute,ProjectController.ownerProject)
project.get("/detail/:id",getAccessToRoute,ProjectController.projectDetail)
project.get("/user-projects",getAccessToRoute,ProjectController.getProjects)
project.get("/projects",ProjectController.getAllProjects)

project.post("/add-project",getAccessToRoute,ProjectController.addProject)
project.post("/:id/save-doc",getAccessToRoute,ProjectController.saveDoc)
project.post("/create-doc",getAccessToRoute,ProjectController.createDoc)

project.put("/edit/:id",getAccessToRoute,ProjectController.editProject)

project.delete("/:id",getAccessToRoute,ProjectController.deleteProject)
project.delete("/:id/delete-doc",getAccessToRoute,ProjectController.deleteDoc)



export default project;