import mongoose from "mongoose";

const {Schema} = mongoose;

const ContactSchema = new Schema({
    title:{
        type:String,
        required: true
    },
    message:{
        type:String,
        required: true,
    },
    send_date:{
        type:Date,
        default:Date.now,
        required:true
    }

})

export default mongoose.model("Contact",ContactSchema);