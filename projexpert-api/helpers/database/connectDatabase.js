import mongoose from "mongoose";

export const connectDatabase = () => {
    mongoose.connect(process.env.MONGO_URI, {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })
        .then(() => { console.log("MongoDb connect successful") })
        .catch(err => console.error(err));
}

export const closeDatabaseConnection = async () => {
    mongoose.connection.close()
        .then(() => { console.log("MongoDb connection closed") })
        .catch(err => { console.log(err) })
}