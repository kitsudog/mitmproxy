from collections.abc import Callable, Sequence
from typing import Any

from mitmproxy.contrib import click as miniclick

from mitmproxy import http
from mitmproxy import ctx
import os

FLOW_NUMBER = int(os.environ.get("FLOW_NUMBER", "10000"))


def response(flow: http.HTTPFlow) -> None:
    count = ctx.master.view.store_count()
    print(miniclick.style(f"count: {count}/{FLOW_NUMBER}"))
    if count >= FLOW_NUMBER:
        print(miniclick.style(f"clear flow"))
        ctx.master.view.clear()
        ctx.master.events.clear()
