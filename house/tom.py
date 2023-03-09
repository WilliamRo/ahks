import traceback
import sys
import jerry

import configs


try:
  # Get arguments
  parts = sys.argv[1:]

  if len(parts) == 0: func_key = 'python'
  else:
    # Check CMD_MAP if shortcuts are provided
    if all([len(parts) == 1, hasattr(configs, 'CMD_MAP'),
            parts[0] in configs.CMD_MAP]):
      parts = configs.CMD_MAP[parts[0]].split(' ')
    func_key = parts.pop(0)

  args, kwargs = [], {}
  for p in parts:
    if '=' in p:
      _p = p.split('=')
      if len(_p) != 2: raise Exception(f'Cannot parse `{p}`')
      kwargs[_p[0]] = _p[1]
    else: args.append(p)

  # Call
  jerry.call(func_key, args, kwargs)

except Exception as e:
  print('[tom.py] Exception:')
  print('-' * 79)
  print(traceback.format_exc())
  print('-' * 79)
  input('Press any key to quit ...')
