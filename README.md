# SFT_gcc_plugin

SFT is a gcc plugin to instrument manual prioritized Structure Field Transition to enhange data alignment toward the memory data sequence prefetchability enhancement and cache-line usage improvement.

## Installation

Use the Makefile to make the plugin

```bash
#plugin_name should be path specific
make plugin_name={***plugin_name***}
```

## Usage

```python
import foobar

foobar.pluralize('word') # returns 'words'
foobar.pluralize('goose') # returns 'geese'
foobar.singularize('phenomena') # returns 'phenomenon'
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
