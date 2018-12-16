"use strict";

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");

var _path = _interopRequireDefault(require("path"));

var _index = _interopRequireDefault(require("../index"));

/**
 * Testing dot path
 */
describe('acceptDotPath', function () {
  it('should accept unprefixed path', function () {
    expect((0, _index.default)('foobar')).toBe(_path.default.join(process.cwd(), 'foobar'));
  });
  it('should accept unprefixed path with custom cwd', function () {
    expect((0, _index.default)('foobar', '/home/user')).toBe(_path.default.join('/home/user', 'foobar'));
  });
  it('should accept relative path', function () {
    expect((0, _index.default)('/foobar')).toBe('/foobar');
  });
  it('should accept relative path with custom cwd', function () {
    expect((0, _index.default)('/foobar', '/home/user')).toBe('/foobar');
  });
  it('should accept dot path', function () {
    expect((0, _index.default)('./foobar')).toBe(_path.default.join(process.cwd(), 'foobar'));
  });
  it('should accept dot path with custom cwd', function () {
    expect((0, _index.default)('./foobar', '/home/user')).toBe(_path.default.join('/home/user', 'foobar'));
  });
  it('should accept dot path with ..', function () {
    expect((0, _index.default)('../foobar')).toBe(_path.default.join(process.cwd(), '../foobar'));
  });
  it('should accept dot path with .. and custom cwd', function () {
    expect((0, _index.default)('../foobar', '/home/user')).toBe(_path.default.join('/home/user', '../foobar'));
  });
});