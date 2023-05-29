from collections.abc import Callable, Sequence
from typing import Any

from mitmproxy.addons import dumper
from mitmproxy.addons.export import curl_command
from mitmproxy.contrib import click as miniclick

from mitmproxy import http


class Dumper(dumper.Dumper):
    def load(self, loader):
        super().load(loader)
        loader.add_option(
            "flow_detail",
            int,
            4,
            """
            The display detail level for flows in mitmdump: 0 (quiet) to 4 (very verbose).
              0: no output
              1: shortened request URL with response status code
              2: full request URL with response status code and HTTP headers
              3: 2 + truncated response content, content of WebSocket and TCP messages
              4: 3 + nothing is truncated
            """,
        )


addons = [Dumper()]


def response(flow: http.HTTPFlow) -> None:
    print(miniclick.style(f"+ CMD: {curl_command(flow)}", fg="yellow"))
