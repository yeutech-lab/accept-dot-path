import path from 'path';

export default function acceptDotPath(p, cwd) {
  if (p[0] === '/') {
    return p;
  }
  const c = cwd || process.cwd();
  return p[1] === '/' ? path.join(c, p.slice(2)) : path.join(c, p);
}
