const { RtcTokenBuilder, RtcRole } = require('agora-access-token');

const appId = '8ed333224c314c06ba4e7b9203bdfc7b';
const appCertificate = 'b1af3d852d7c49d3862ffa9f47e2635a';
const channelName = 'test';
const uid = 0; // Use 0 for auto-assigned UID
const role = RtcRole.PUBLISHER;
const expireTime = 3600; // Token expiration time in seconds

function generateToken() {
  const token = RtcTokenBuilder.buildTokenWithUid(appId, appCertificate, channelName, uid, role, expireTime);
  console.log(token);
  return token;
}

const express = require('express');
const app = express();

app.get('/getToken', (req, res) => {
  const token = generateToken();
  res.json({ token });
});

app.listen(3000, () => console.log('Server running on port 3000'));
