const dotenv = require('dotenv');
const Keycloak = require('keycloak-connect');
const session = require('express-session');
const MemoryStore = require('memorystore')(session);

dotenv.config();

const memoryStore = new MemoryStore({ checkPeriod: 86400000 });

const keycloakConfig = {
  clientId: process.env.KEYCLOAK_CLIENT_ID,
  bearerOnly: false,
  serverUrl: process.env.KEYCLOAK_URL,
  realm: process.env.KEYCLOAK_REALM,
  credentials: { secret: process.env.KEYCLOAK_CLIENT_SECRET },
  "confidential-port": 0
};

const keycloak = new Keycloak({ store: memoryStore }, keycloakConfig);

module.exports = { keycloak, memoryStore };
