/**
 * Testing dot path
 */
import path from 'path';
import acceptDotPath from '../index';

describe('acceptDotPath', () => {
  it('should accept unprefixed path', () => {
    expect(acceptDotPath('foobar')).toBe(path.join(process.cwd(), 'foobar'));
  });
  it('should accept unprefixed path with custom cwd', () => {
    expect(acceptDotPath('foobar', '/home/user')).toBe(path.join('/home/user', 'foobar'));
  });

  it('should accept relative path', () => {
    expect(acceptDotPath('/foobar')).toBe('/foobar');
  });
  it('should accept relative path with custom cwd', () => {
    expect(acceptDotPath('/foobar', '/home/user')).toBe('/foobar');
  });

  it('should accept dot path', () => {
    expect(acceptDotPath('./foobar')).toBe(path.join(process.cwd(), 'foobar'));
  });
  it('should accept dot path with custom cwd', () => {
    expect(acceptDotPath('./foobar', '/home/user')).toBe(path.join('/home/user', 'foobar'));
  });

  it('should accept dot path with ..', () => {
    expect(acceptDotPath('../foobar')).toBe(path.join(process.cwd(), '../foobar'));
  });
  it('should accept dot path with .. and custom cwd', () => {
    expect(acceptDotPath('../foobar', '/home/user')).toBe(path.join('/home/user', '../foobar'));
  });
});
