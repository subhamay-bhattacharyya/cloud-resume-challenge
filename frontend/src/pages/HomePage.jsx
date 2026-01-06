import React from "react";
import 'css/pages/home.css'
import subhamay_bhattacharyya from 'images/subhamay-bhattacharyya-thumb.webp'
import blogData from 'data/blogData.json'
import linksData from 'data/linksData.json'
import PostItem from 'comps/PostItem'
import ViewCounter from 'comps/ViewCounter'
export default function HomePage() {
  const sortedBlogData = [...blogData].sort((a, b) => new Date(b.date) - new Date(a.date));

  return (
    <>
      <h1 className='fancy'>Subhamay Bhattacharyya's Blog</h1>
      <ViewCounter />
      <div className="intro_video">
        <img src={subhamay_bhattacharyya} />
      </div>
      <div className="links">
        {linksData.map((link) => (
          <a key={link.url} target="_blank" href={link.url}>
            <span className="icon" dangerouslySetInnerHTML={{ __html: link.icon }} />
            <span className="name">{link.name}</span>
          </a>
        ))}
      </div>

      <section className='posts'>
        <h2>Recent Posts</h2>
        {sortedBlogData.map((post) => (
          <PostItem key={post.handle} post={post} />
        ))}
      </section>
    </>
  )
}