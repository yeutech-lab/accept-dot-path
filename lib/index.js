"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = acceptDotPath;

var _path = _interopRequireDefault(require("path"));

function acceptDotPath(p, cwd) {
  if (p[0] === '/') {
    return p;
  }

  var c = cwd || process.cwd();
  return p[1] === '/' ? _path.default.join(c, p.slice(2)) : _path.default.join(c, p);
}

module.exports = exports.default;