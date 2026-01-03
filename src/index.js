import express from "express";
import dotenv from "dotenv";
import router from "../backend/routes/index.js";

dotenv.config();

const app = express();
app.use(express.json());

// Tüm LumiAI backend router'ları buraya bağlı
app.use("/", router);

const PORT = 4000;
app.listen(PORT, () => {
  console.log(`LumiAI Core running at http://localhost:${PORT}`);
});