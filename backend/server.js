require("dotenv").config();
const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors({ origin: "*"}));
app.use(express.json({ limit: "1mb" }));

app.get("/", (req, res) => {
  res.status(200).send("LumiAI backend OK");
});

app.get("/health", (req, res) => {
  res.status(200).json({ ok: true, service: "lumiai-backend" });
});

app.post("/api/chat", async (req, res) => {
  const { message } = req.body || {};
  if (!message || typeof message !== "string") {
    return res.status(400).json({ reply: "Lumi: message is empty." });
  }

  // ŞİMDİLİK MOCK (AI entegresi bir sonraki adımda)
  return res.json({ reply: "Mock cevap: " + message });
});

const port = Number(process.env.PORT || 3000);
app.listen(port, "0.0.0.0", () => {
  console.log(`LumiAI backend ${port} portunda çalışıyor`);
});
