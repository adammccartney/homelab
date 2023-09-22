#!/usr/bin/env python3

import argparse
import os

from pathlib import Path
from jinja2 import Environment, FileSystemLoader

__doc__ = """k8snet.py quick script to configuret the network plugin yaml file
for setting up a k8s network plugin using kubeadm"""


def load_settings():
    settings = {}
    settings.update({
        "k8s_initial_master": os.getenv("K8S_INITIAL_MASTER"),
        "k8s_pod_cidr": os.getenv("K8S_POD_CIDR"),
        "k8s_control_plane_endpoint": os.getenv("K8S_CONTROL_PLANE_ENDPOINT"),
        "k8s_join_token": os.getenv("K8S_JOIN_TOKEN"),
        "k8s_certificate_key": os.getenv("K8S_CERTIFICATE_KEY"),
        "k8s_version": os.getenv("K8S_VERSION")
        })
    return settings

templates = Path.joinpath(Path(__file__).parent.parent, "templates")

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", "--template", help="filename of jinja2 template")
    parser.add_argument("--set",
                        metavar="KEY=VALUE",
                        nargs='+',
                        help="Set a number of key-value pairs")
    args = parser.parse_args()
    return args

def create_env(args):
    # just cast the argparse.Namespace object to a dictionary
    settings = load_settings()
    env = {}
    env.update(settings)
    env.update({
        "template": args.template,
        })
    if env["template"] is not None:
        env["outfile"] = env["template"].strip(".j2")
    if args.set is not None:
        custom_vars = dict(map(lambda s: s.split('='), args.set))
        env.update(custom_vars)
    return env

def process_template(env):
    environment = Environment(loader=FileSystemLoader(templates))
    template = environment.get_template(env["template"])
    content = template.render(env)
    print(content)

def main():
    # get args
    args = get_args()
    env = create_env(args)
    # find template and output file
    process_template(env)

if __name__ == '__main__':
    main()

