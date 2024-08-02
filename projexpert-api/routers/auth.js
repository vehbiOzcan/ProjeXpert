import express from 'express'
import AuthController from '../controllers/auth/AuthController.js';
import { profileImageUpload } from '../middleware/libraries/profileImageUploads.js';
import { getAccessToRoute } from '../middleware/auth/auth.js';
import { checkEmailExist } from '../middleware/database/databaseCheckUser.js';

const auth = express.Router();
//register
auth.post("/register", AuthController.registerper);
//login
auth.post("/login",checkEmailExist, AuthController.loginP);
//logout
auth.get("/logout", getAccessToRoute, AuthController.logoutP)
//ResetPassword
auth.put("/resetpassword",AuthController.resetPassword)
//test
auth.post("/upload", getAccessToRoute, profileImageUpload.single("profile_image"), AuthController.imageUpload);
auth.get("/tokentest", getAccessToRoute, AuthController.tokenTest);
auth.get("/profile", getAccessToRoute, AuthController.getUser);

export default auth;