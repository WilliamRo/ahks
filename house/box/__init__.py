import pkgutil

modules = []
for loader, module_name, is_pkg in  pkgutil.walk_packages(__path__):
  _module = loader.find_module(module_name).load_module(module_name)
  modules.append(_module)