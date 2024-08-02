import mongoose from "mongoose";
import bcyrpt from 'bcryptjs';
import jwt from 'jsonwebtoken'


const {Schema} = mongoose;

const UserSchema = new Schema({
    
    name:{
        type: String,
        required: [true, "Please entry a name"]
    },
    email:{
        type:String,
        required: true,
        unique: [true, "Please different email"],
        match: [/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/, "Please provide a valid email"]
    },
    password:{
        type: String,
        required: [true,"Please provide a password"],
        minlength: [6, "Password provide a password with min length 6"],
        selected:false
    },
    phone:{
        type:String,
        
    },
    adress:{
        type:String
    },
    gender:{
        type: String,
        default: "1",
        enum: ["1", "2", "3"],
    },
    avatar:{
        type:String,
        default: "default.jpg"
    }
 
})

UserSchema.methods.generateJwtFromUser = function() {
    
    const {JWT_SECRET_KEY, JWT_EXPIRE} = process.env;

    const payload = {
        id: this._id,
        name: this.name 
    }

    const token = jwt.sign(payload,JWT_SECRET_KEY,{
        expiresIn:JWT_EXPIRE
    });

    return token;
}



UserSchema.pre("save",function(next){

    if(!this.isModified("password")){
        next();
    }

    bcyrpt.genSalt(10,(err,salt) => {
        if(err) next(err);
        bcyrpt.hash(this.password, salt, (err,hash) => {
            if(err) next(err);
            this.password = hash;
            next();
        })
    })
})

//Mongoose içerisine modelimizi kayıt ettik ve export ettik

export default mongoose.model("User",UserSchema);