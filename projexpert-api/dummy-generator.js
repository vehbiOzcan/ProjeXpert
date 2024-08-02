import Project from "./models/Project.js";
import User from "./models/User.js";
import fs from 'fs'
import { connectDatabase } from "./helpers/database/connectDatabase.js";
import dotenv from 'dotenv'

const path = "./dummy/";

const users = JSON.parse(fs.readFileSync(path + "user.json" ));
const projects = JSON.parse(fs.readFileSync(path + "project.json" ));


dotenv.config({
    path : "./config/env/config.env"
});

connectDatabase();

const importAllData = async function(){
    try {
        await User.create(users);
        await Project.create(projects);
        console.log("Import Process Successful");

    }   
    catch(err) {
        console.log(err);
        console.err("There is a problem with import process");
    }
    finally {
        process.exit();
    }
};

const deleteAllData = async function(){
    try {
        await User.deleteMany();
        await Project.deleteMany();
        console.log("Delete Process Successful");


    }   
    catch(err) {
        console.log(err);
        console.err("There is a problem with delete process");
    }
    finally {
        process.exit();
    }
};

if (process.argv[2] == "--import"){
    importAllData();
}
else if (process.argv[2] == "--delete"){
    deleteAllData();
}
