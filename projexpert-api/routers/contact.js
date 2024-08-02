import express from 'express'
import { getAccessToRoute } from '../middleware/auth/auth.js';
import ContactController from '../controllers/user/ContactController.js';

const contact = express.Router();

contact.post("/",ContactController.addMessage)
contact.get("/",getAccessToRoute,ContactController.getAllMessage)
contact.get("/:id",getAccessToRoute,ContactController.getMessageFromId)
contact.delete("/:id",getAccessToRoute,ContactController.deleteMessage)


export default contact;