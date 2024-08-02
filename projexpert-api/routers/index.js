import express from 'express'
import auth from './auth.js';
import user from './user.js';
import project from './project.js';
import contact from './contact.js';


const router = express.Router();

router.use("/auth", auth);
router.use("/personal", user);
router.use("/project",project);
router.use("/contact",contact);


export default router;