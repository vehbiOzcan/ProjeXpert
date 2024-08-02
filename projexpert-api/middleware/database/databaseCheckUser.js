import User from "../../models/User.js";
import CustomError from "../../helpers/Error/CustomError.js";
import asyncErrorWrapper from "../../helpers/Error/asyncErrorWrapper.js";

const checkPersonalExist = asyncErrorWrapper(async (req,res,next) => { 
    //Kullanıcı sorgularında sürekli hata mesajı yamamak için bu middleware yazdık
    const {id} = req.params;

    const personal = await User.findById(id).select("-password")
    
    if(!personal){
        return next(new CustomError("There is no such user with that id",400))
    }
    next();
})



const checkUserExist = asyncErrorWrapper(async (req,res,next) => { 
    //Kullanıcı sorgularında sürekli hata mesajı yamamak için bu middleware yazdık
    const {id} = req.params;

    const vet = await Vet.findById(id).select("-password")
    const personal = await User.findById(id).select("-password")
    
    if(!vet && !personal){
        return next(new CustomError("There is no such user with that id",400))
    }
    next();
})

const checkEmailExist = asyncErrorWrapper(async(req,res,next) => {
      //Kullanıcı sorgularında sürekli hata mesajı yamamak için bu middleware yazdık
      const {email} = req.body;

      const personal = await User.findOne({email:email}).select("-password")
      
      if(!personal){
          return next(new CustomError("There is no such user with that id",400))
      }
      next();
})

export {checkPersonalExist,checkUserExist, checkEmailExist}