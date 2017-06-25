## Installation
```
> npm i -g iced-reat-compgen
```

## Usage
```
> iced-react-compgen
```

## Component Generation
The command will launch an interactive prompt which will ask you for the name of the component and the directory to write the file to (relative to the current path). The filename will be the name of the component with an 'iced' file extension. Session example:

```
user@sys:~/apps/my-app$ Enter name of component: MyComponent  
user@sys:~/apps/my-app$ Enter directory name: src/
Component MyComponent.iced generated in /home/user/my-app/src/MyComponent.iced
user@sys:~/apps/my-app$ cat src/MyComponent.iced
React = require 'react'

class MyComponent extends React.Component
  constructor: (props)->
    super props

  render: ->
    <div>
    </div>

module.exports = MyComponent
```
