const session = require('express-session');
const MemoryStore = require('memorystore')(session);
const { Issuer } = require('openid-client');

const memoryStore = new MemoryStore({ checkPeriod: 86400000 });

async function initOidcClient(port) {
  const issuer = await Issuer.discover(
    `${process.env.KC_SERVER_URL}/realms/${process.env.KC_REALM}`
  );

  const redirectUri = `http://localhost:${port}/auth/callback`;
  const postLogoutRedirectUri = `http://localhost:${port}/`;

  const client = new issuer.Client({
    client_id: process.env.KC_CLIENT_ID,
    client_secret: process.env.KC_CLIENT_SECRET,
    redirect_uris: [redirectUri],
    response_types: ['code']
  });

  return { client, redirectUri, postLogoutRedirectUri };
}

module.exports = { memoryStore, initOidcClient };
