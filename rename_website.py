#!/usr/bin/env python3
import os
import sys

class Rename(object):

    def __init__(self, old, new):
        # python rename_website.py old_link new_link
        old_link = old
        new_link = new
        os.chdir(os.getcwd() + "/source/locales/")

        for text_file in os.listdir(os.getcwd()):
            content = str()
            i_have_to_rewrite_this_file = str()

            with open(text_file, 'rt') as f:
                for current_line in f.readlines():
                    if old_link in current_line:
                        content += current_line.replace(old_link, new_link)
                        i_have_to_rewrite_this_file = 'definitely'
                    else:
                        content += current_line

            if i_have_to_rewrite_this_file:
                with open(text_file, 'wt') as out:
                    out.write(content)

if __name__ == '__main__':
    Rename(str(sys.argv[1]), str(sys.argv[2]))