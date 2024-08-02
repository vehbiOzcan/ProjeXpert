import express from 'express'
import UserController from '../controllers/user/UserController.js';
import { checkPersonalExist } from '../middleware/database/databaseCheckUser.js';
import {getAccessToRoute, getPersonalAccess} from '../middleware/auth/auth.js'

const user = express.Router()

user.get("/",UserController.getAllUser)
user.get("/profile",getAccessToRoute,getPersonalAccess,UserController.getUserProfile)
user.get("/:id",checkPersonalExist,UserController.getSingleUser)
user.put("/edit",getAccessToRoute,UserController.editUser)

export default user;