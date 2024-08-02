import CustomError from "../../helpers/Error/CustomError.js";

export const customErrorHandler = (err,req,res,next) => {
    
    let customErr = err;

    if(err.name === "SyntaxError"){
        customErr = new CustomError(err.message,400);
    }

    if(err.name === "ValidationError"){
        customErr = new CustomError(err.message,400);
    }
    if(err.code === 11000 ){
        //Dublicate key
        customErr = new CustomError("Duplicate Key Found : Check Your Inputs", 400)
    }
    console.log(customErr.message, customErr.status)
    
    res
    .status(customErr.status || 500)
    .json(
        {
            success: false,
            message: customErr.message || "Internal Server Error"
        }
    )

} 