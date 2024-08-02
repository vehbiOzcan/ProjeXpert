import CustomError from "../../helpers/Error/CustomError.js";
import asyncErrorWrapper from "../../helpers/Error/asyncErrorWrapper.js";
import Contact from '../../models/Contact.js'

const addMessage = asyncErrorWrapper(async (req, res, next) => {
    const data = req.body;
    const message = await Contact.create({ ...data })

    res.status(200).json({
        success: true,
        data: message
    })
})

const getAllMessage = asyncErrorWrapper(async (req, res, next) => {
    const messages = await Contact.find();

    res.status(200).json({
        success: true,
        data: messages
    })
})

const getMessageFromId = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params
    const messages = await Contact.findById(id);

    res.status(200).json({
        success: true,
        data: messages
    })
})

const deleteMessage = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params;
    console.log(id)
    const messages = await Contact.findByIdAndRemove(id);

    res.status(200).json({
        success: true,
        message: "Delete message successfull"
    })
})

const ContactController = { addMessage, getAllMessage, getMessageFromId, deleteMessage }

export default ContactController;

