# pip install dominate
import dominate
import json
from dominate.tags import (
    meta, title, link, body, main, header, nav, a, div, article,
    section, h1, h2, h3, h4, h5, p, ul, li, br
)
from dominate.util import raw

PAGE = json.load(open("data.json"))

def build_item_heading(it: dict):
    h3(it["info_title"]) if it.get("info_title", None) else None
    with div(cls="item_heading"):
        with div(cls="info"):
            h5(it["info_subtitle"]) if it.get("info_subtitle", None) else None
        with div(cls="details"):
            details = it.get("details", {})
            location_duration = ""
            if "location" in details:
                location_duration = details["location"]
            if "duration" in details:
                location_duration += f' • {details["duration"]}'
            if location_duration:
                div(location_duration, cls="duration")


def build_section(sec: dict):
    with section(cls=sec["class"]):
        h2(sec["title"])

        if sec["class"] == "skills":
            for group in sec["items_groups"]:
                with div(cls="items"):
                    for it in group:
                        with div(cls="item"):
                            build_item_heading(it)
            return

        with div(cls="items"):
            for it in sec["items"]:
                with div(cls="item"):
                    build_item_heading(it)

                    bullets = it.get("bullets") or []
                    if bullets:
                        with ul():
                            for b in bullets:
                                if isinstance(b, list):
                                    attrs = {"href": b[1], "target": "_blank"}
                                    li(a(b[0], **attrs))
                                else:
                                    li(b)


def build_page(page: dict) -> dominate.document:
    doc = dominate.document(None)

    # ✅ Add head content explicitly (dominate already has <head>, so just add tags)
    for m in page["head"]["meta"]:
        doc.head.add(meta(**m))
    doc.head.add(title(page["head"]["title"]))
    for css in page["head"]["stylesheets"]:
        doc.head.add(link(rel="stylesheet", href=css))

    # ✅ Body content
    with doc:
        with body(location=page["body"]["location"]):
            with main():
                with header():
                    with nav():
                        for item in page["body"]["nav"]:
                            attrs = {"href": item["href"]}
                            if "class" in item:
                                attrs["cls"] = item["class"]  # dominate uses cls=
                            a(item["text"], **attrs)

                with div(cls="content_wrap"):
                    with div(cls="content"):
                        with article():
                            hs = page["body"]["header_section"]
                            with section(cls="header"):
                                h1(hs["name"])
                                h4(f'{hs["address"]} • {hs["phone"]} • {hs["email"]}')

                            for sec in page["body"]["sections"]:
                                build_section(sec)

                            div(page["body"]["disclaimer"], cls="disclaimer")

    return doc


if __name__ == "__main__":
    with open("../../frontend/public/index.html", "w") as f:
        f.write(build_page(PAGE).render())  # Dominate prints one <!DOCTYPE html>