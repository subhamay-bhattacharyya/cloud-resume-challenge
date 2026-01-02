# pip install dominate
import dominate
import json
from dominate.tags import (
    meta, title, link, body, main, header, nav, a, div, article,
    section, h1, h2, h3, p, ul, li
)
from dominate.util import raw

PAGE = json.load(open("data.json"))

def build_item_heading(it: dict):
    with div(cls="item_heading"):
        with div(cls="info"):
            h3(it["info_title"])
            p(it["info_subtitle"])
        with div(cls="details"):
            details = it.get("details", {})
            if "location" in details:
                div(details["location"], cls="location")
            if "code" in details:
                div(details["code"], cls="code")
            if "duration" in details:
                div(details["duration"], cls="duration")


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
                                li(b[0], href=b[1]) if isinstance(b, list) else li(b)


def build_page(page: dict) -> dominate.document:
    doc = dominate.document()
    doc.head.add(title(page["head"]["title"]))

    # doc = dominate.document(title=page["head"]["title"])

    # ✅ Correct way to set <html lang="en"> in Dominate
    # doc.document_element["lang"] = page["html"]["lang"]

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
                                with p():
                                    # keep exact bullets + mailto as in your sample
                                    doc.add(raw(
                                        f"""{hs["address"]}
                &bull;
                <a href="mailto:{hs["email"]}">{hs["email"]}</a>
                &bull;
                {hs["phone"]}"""
                                    ))

                            for sec in page["body"]["sections"]:
                                build_section(sec)

                            div(page["body"]["disclaimer"], cls="disclaimer")

    return doc


if __name__ == "__main__":
    with open("../../frontend/public/index.html", "w") as f:
        f.write(build_page(PAGE).render())  # Dominate prints one <!DOCTYPE html>