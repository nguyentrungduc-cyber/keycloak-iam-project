const express = require('express');
const { generators } = require('openid-client');
const router = express.Router();

router.get('/login', (req, res) => {
  const client = req.app.locals.oidcClient;
  const redirectUri = req.app.locals.oidcRedirectUri;

  const state = generators.state();
  const nonce = generators.nonce();
  const codeVerifier = generators.codeVerifier();
  const codeChallenge = generators.codeChallenge(codeVerifier);

  req.session.oidc = { state, nonce, codeVerifier };

  const authUrl = client.authorizationUrl({
    scope: 'openid profile email',
    response_type: 'code',
    redirect_uri: redirectUri,
    state,
    nonce,
    code_challenge: codeChallenge,
    code_challenge_method: 'S256'
  });

  return res.redirect(authUrl);
});

router.get('/callback', async (req, res) => {
  try {
    const client = req.app.locals.oidcClient;
    const redirectUri = req.app.locals.oidcRedirectUri;
    const sessionOidc = req.session.oidc;

    if (!sessionOidc) {
      return res.status(400).render('error', { message: 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.' });
    }

    const params = client.callbackParams(req);
    const tokenSet = await client.callback(
      redirectUri,
      params,
      {
        state: sessionOidc.state,
        nonce: sessionOidc.nonce,
        code_verifier: sessionOidc.codeVerifier
      }
    );

    const claims = tokenSet.claims();
    req.session.tokenSet = {
      id_token: tokenSet.id_token,
      access_token: tokenSet.access_token,
      refresh_token: tokenSet.refresh_token,
      expires_at: tokenSet.expires_at,
      token_type: tokenSet.token_type,
      scope: tokenSet.scope,
      session_state: tokenSet.session_state
    };
    req.session.user = claims;
    req.session.roles = claims.realm_access?.roles || [];
    delete req.session.oidc;

    return res.redirect('/dashboard');
  } catch (err) {
    return res.status(401).render('error', { message: `Đăng nhập thất bại: ${err.message}` });
  }
});

router.get('/logout', (req, res) => {
  const client = req.app.locals.oidcClient;
  const postLogoutRedirectUri = req.app.locals.postLogoutRedirectUri;
  const idTokenHint = req.session?.tokenSet?.id_token;

  req.session.destroy(() => {
    const logoutUrl = client.endSessionUrl({
      post_logout_redirect_uri: postLogoutRedirectUri,
      id_token_hint: idTokenHint
    });
    res.redirect(logoutUrl);
  });
});

module.exports = router;
