import mongoose from "mongoose";

const { Schema } = mongoose;

const ProjectSchema = new Schema({
    projectNo: {
        type: String,
        required: true
    },
    projectName: {
        type: String,
        required: [true, "Please entry a name"]
    },
    status: {
        type: String,
        required: true

    },
    
    createDate: {
        type: Date,
        default: Date.now,
    },
    updateDate: [
        {   
            name: {
                type: String,
                required:true
            },
            dose: {
                type: String,
                required:true
            },
            date:{
                type:Date,
                default:Date.now,
                required: true
            },
        }
    ],
    projectDocs: [
        {   
            name: {
                type: String,
                required:true
            },
            docType: {
                type: String,
                required:true
            },
            content: {
                type: String,
                required:true
            },
            date:{
                type:Date,
                default:Date.now,
                required: true
            },
        }
    ],
    projectOwner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
       
    }

})


//Mongoose içerisine modelimizi kayıt ettik ve export ettik

export default mongoose.model("Project", ProjectSchema);