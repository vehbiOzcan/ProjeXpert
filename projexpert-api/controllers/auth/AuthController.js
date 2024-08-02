import asyncErrorWrapper from '../../helpers/Error/asyncErrorWrapper.js'
import { comparePassword, validateUserInput } from '../../helpers/input/inputHelpers.js'
import CustomError from '../../helpers/Error/CustomError.js'
import User from '../../models/User.js'
import { sendJwtToClient } from '../../helpers/auth/tokenHelpers.js'


const registerUser = asyncErrorWrapper(async (req, res, next) => {
    console.log(req.body);

    const data = req.body;

    const user = await User.create(
        data
    );

    sendJwtToClient(user, res);
})


const loginP = async (req, res, next) => {

    const { email, password } = req.body;
    console.log(email, password);

    if (!validateUserInput(email, password)) {
        return next(new CustomError("please check your inputs", 400))
    }

    const person = await User.findOne({ email }).select("+password");

    if (!comparePassword(password, person.password)) {
        return next(new CustomError("plesae check your inputs credentily", 400))
    }

    const { _id, name, phone, adress, gender, avatar, school } = person;
    sendJwtToClient(person, res);
}


const logoutP = asyncErrorWrapper(async (req, res, next) => {
    const { NODE_ENV } = process.env;

    res.status(200).cookie({
        httpOnly: true,
        expires: new Date(Date.now()),
        secure: NODE_ENV === 'developmet' ? true : false
    })
        .json({
            success: true,
            message: "Logout Successfull"
        })

})




//Forgot password
const resetPassword = asyncErrorWrapper(async (req, res, next) => {
    const {resetPasswordToken} = req.query;
    const  {password} = req.body;

    if(!resetPasswordToken){
        return next(new CustomError("Please provide a valid token",400))
    }

    let user = await User.findOne({
        resetPasswordToken:resetPasswordToken,
        resetPasswordExpire: {$gt : Date.now()}
    });

    if(!user){
        return next(new CustomError("Invalid token or Session Expired",400))
    }

    user.password = password;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpire = undefined;

    await user.save();

    return res.status(200).json({
        success:true,
        message:"Reset password successfull"
    })
})


const imageUpload = asyncErrorWrapper(async (req, res, next) => { //resmin konumunu db ye güncelleme user id yardımıyla 

    let user;
    console.log(req.headers)
    if (req.headers.schematype == 'personal') {
        user = await User.findByIdAndUpdate(req.user?.id, {
            "avatar": req.savedProfileImage
        }, { //güncellenmiş user gelir bu parametre sayesinde
            new: true,
            runValidators: true,
        }).select("-password");
    }

    if (req.headers.schematype === "vet") {
        user = await Vet.findByIdAndUpdate(req.user?.id, {
            "avatar": req.savedProfileImage
        }, {
            new: true,
            runValidators: true,
        }).select("-password");
    }

    res.status(200).json({
        success: true,
        message: "Image upload successfull",
        data: user
    })
})

const tokenTest = (req, res, next) => {
    res
        .status(200)
        .json({
            success: true,
            message: "Welcome"
        })
}

const getUser = (req, res, next) => {
    //getAccessToRoute middleware da kayıt ettiğimiz veriler
    res.status(200).json({
        success: true,
        data: {
            id: req.user.id,
            name: req.user.name
        }
    })
}

const AuthController = {
    registerper: registerUser,
    loginP,
    imageUpload, tokenTest, getUser,
    logoutP,
    resetPassword
}

export default AuthController;