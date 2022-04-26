import configs
import subprocess
import os, sys
import inspect

from box import modules


def try_to_map(value: str):
  if value in configs.PATH_MAP: return configs.PATH_MAP[value]
  return value


def popen(func: str, *args):
  if func == 'python':
    subprocess.check_call([sys.executable, *args])
    return

  # TODO: explorer should be executed without env
  kwargs = {}
  if func in configs.FUNC_MAP: func = configs.FUNC_MAP[func]
  else: kwargs['env'] = dict(path=os.environ.get('path'))

  args = [func] + list(args)
  subprocess.Popen(args, **kwargs)


def call(func_name: str, args: list, kwargs: dict):
  # Get method
  func = None
  for m in modules:
    if func_name in dir(m):
      func = getattr(m, func_name)
      if callable(func): break
  if func is None:
    print('>> func set to default')
    func = popen
    args.insert(0, func_name)

  # Try to execute func
  params_dict = inspect.signature(func).parameters
  params_values = list(params_dict.values())
  has_annotation = lambda p: p.annotation is not inspect._empty

  # Try to convert args type
  for i in range(len(args)):
    args[i] = try_to_map(args[i])
    if func != popen:
      p = params_values[i]
      if has_annotation(p): args[i] = p.annotation(args[i])
  # Try to convert kwargs type
  for k, v in kwargs.items():
    p = params_dict[k]
    v = try_to_map(v)
    if has_annotation(p): kwargs[k] = p.annotation(v)

  # Execute
  func(*args, **kwargs)