#!/usr/bin/env python
import re
import argparse

def main():
    parser = argparse.ArgumentParser(description='Convert strings from CamelCase to snake_case and vice versa')
    parser.add_argument('-n', '--name', metavar='N', required=True, type=str, help='the string to convert')

    args = parser.parse_args()
    if '_' in args.name:
        print(snake_to_camel(args.name))
    else:
        print(camel_to_snake(args.name))
                   
def camel_to_snake(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def snake_to_camel(name):
    return ''.join(x.capitalize() or '_' for x in name.split('_'))
    

if __name__ == "__main__":
    main()
