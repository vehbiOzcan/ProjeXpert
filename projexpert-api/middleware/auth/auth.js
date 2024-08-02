import CustomError from '../../helpers/Error/CustomError.js'
import jwt from 'jsonwebtoken'
import { getTokenFromHeader, isTokenIncluded } from '../../helpers/auth/tokenHelpers.js'
import asyncErrorWrapper from '../../helpers/Error/asyncErrorWrapper.js';
import User from '../../models/User.js';


const getAccessToRoute = (req, res, next) => {
    const { JWT_SECRET_KEY } = process.env;
    //Token control
    if (!isTokenIncluded(req)) {
        return next(new CustomError("You are not authorized to access this route", 401));
    }

    const access_token = getTokenFromHeader(req);
    jwt.verify(access_token, JWT_SECRET_KEY, (err, decoded) => {
        if (err) {
            return next(new CustomError("You are not authorized to access token", 401))
        }
        //console.log(decoded);
        //req üzerine decod edilen bilgileri kayır ettik
        req.user = {
            id: decoded.id,
            name: decoded.name
        }
        next();
    })
}



const getPersonalAccess = asyncErrorWrapper(async (req,res,next) => { 
    //Kullanıcı sorgularında sürekli hata mesajı yamamak için bu middleware yazdık
    const id = req.user.id;

    const personal = await User.findById(id).select("-password")
    
    if(!personal){
        return next(new CustomError("Only personals can access to this route",403))
    }
    next();
})



export { getAccessToRoute, getPersonalAccess};
