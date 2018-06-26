It accept UNIX path.

We originally made this just for NodeJS ClI so user can pass path of any kinds to our apps.

**Parameters**

- `path` *(String)*: the path to convert
- `cwd` *(String) (optional)*: a cwd to be used, if none is specified, it will use `process.cwd()`.
 
```jsx harmony
const acceptDotPath = require('$PACKAGE_NAME');

<ul>
  <li><code>acceptDotPath('./.ssh', '/home/user')</code> => {acceptDotPath('./.ssh', '/home/user')}</li>
    <li><code>acceptDotPath('../.ssh', '/home/user')</code> => {acceptDotPath('../.ssh', '/home/user')}</li>
  <li><code>acceptDotPath('/ssh', '/home/user')</code> => {acceptDotPath('/ssh', '/home/user')}</li>
  <li><code>acceptDotPath('ssh', '/home/user')</code> => {acceptDotPath('ssh', '/home/user')}</li>
</ul>
```
