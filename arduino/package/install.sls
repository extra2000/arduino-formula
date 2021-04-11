# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import ARDUINO with context %}

/opt/arduino:
  file.directory:
    - user: {{ ARDUINO.hostuser.name }}
    - group: {{ ARDUINO.hostuser.group }}

add-current-user-to-group-dialout:
  cmd.run:
    - name: usermod --append --groups dialout {{ ARDUINO.hostuser.name }}

arduino-archive-present:
  archive.extracted:
    - name: /opt/arduino
    - source: {{ ARDUINO.package.url }}
    - source_hash: {{ ARDUINO.package.checksum }}
    - user: {{ ARDUINO.hostuser.name }}
    - group: {{ ARDUINO.hostuser.group }}
    - require:
      - file: /opt/arduino
