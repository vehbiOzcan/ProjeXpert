import express, { Router } from 'express'
import dotenv from 'dotenv'
import { connectDatabase, closeDatabaseConnection } from './helpers/database/connectDatabase.js';
import router from './routers/index.js';
import { customErrorHandler } from './middleware/error/customErrorHandler.js';
import path from 'path'
import { fileURLToPath } from 'url'; 
import { dirname } from 'path';
import cors from 'cors'
import { GoogleGenerativeAI } from "@google/generative-ai";

//pathleri oluşturduk
const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename);

//Configuration
dotenv.config({
    path:"./config/env/config.env"
});

//express api oluşturma
const app = express();

app.use(cors());
//Port numarasını ayarlama
const PORT = process.env.PORT;

//Json Middleware
app.use(express.json());

//Connect Database
connectDatabase();

//Router Middleware
app.use("/api", router);

//Error Handler
app.use(customErrorHandler)

//Static Files
app.use(express.static(path.join(__dirname,'public')))
//SERVERI  BAŞLATMA
const server = app.listen(PORT, () => console.log(`Server starded on ${PORT} number : ${process.env.NODE_ENV}`));



// Server kapatıldığında MongoDB bağlantısını kapat
process.on("SIGINT", async () => {
    await closeDatabaseConnection().then(() => console.log("MongoDB Connection closed")).catch(err => console.error(err));
    server.close(() => {
        console.log("Server stopped");
        process.exit();
    });
});

