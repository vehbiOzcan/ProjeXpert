import CustomError from "../../helpers/Error/CustomError.js";
import asyncErrorWrapper from "../../helpers/Error/asyncErrorWrapper.js";
import User from "../../models/User.js";

const getSingleUser = asyncErrorWrapper(async (req, res, next) => {
    const { id } = req.params;

    const user = await User.findById(id).select("-password");

    return res.status(200).json({
        success: true,
        data: user
    })
})

const getUserProfile = asyncErrorWrapper(async (req, res, next) => {
    const  id  = req.user.id;

    const user = await User.findById(id).select("-password");

    return res.status(200).json({
        success: true,
        data: user
    })
})

const getAllUser = asyncErrorWrapper(async (req, res, next) => {

    const users = await User.find().select("-password -email -phone -adress");

    return res.status(200).json({
        success: true,
        data: users
    })
})

const editUser = asyncErrorWrapper(async (req, res, next) => {
    const id = req.user.id;
    const editData = req.body;
    const user = await User.findByIdAndUpdate(id, editData, {
        new: true,
        runValidators: true
    })

    return res.status(200)
        .json({
            success:true,
            data: user
        })

})



const UserController = { getSingleUser,getUserProfile ,getAllUser, editUser: editUser }

export default UserController;