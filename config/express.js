const express = require("express");
var cors = require("cors");
var path = require("path");
const config = require("config");
var bodyParser = require("body-parser");

module.exports = () => {
  const app = express();

  // SETANDO VARIÁVEIS DA APLICAÇÃO
  app.set("port", process.env.PORT || config.get("server.port"));

  //Setando react - assets com hash no nome podem ter cache longo; index.html nunca deve ser cacheado
  app.use(express.static(path.join(__dirname, "../", "client", "build"), {
    index: false, // desabilita servir index.html automaticamente para controlar o cache manualmente
    setHeaders: (res, filePath) => {
      if (filePath.endsWith("index.html")) {
        res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
      }
    }
  }));

  // parse request bodies (req.body)
  app.use(express.urlencoded({ extended: true }));
  app.use(bodyParser.json());

  app.use(cors());

  require("../api/routes/tarefas")(app);
  require("../api/routes/versao")(app);
  require("../api/routes/cache-config")(app);

  // Fallback para React Router - serve index.html sem cache para todas as rotas não-API
  app.get('*', (req, res) => {
    res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    res.sendFile(path.join(__dirname, "../", "client", "build", "index.html"));
  });

  return app;
};
