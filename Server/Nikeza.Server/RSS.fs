module Nikeza.Server.RSS

open System
open RSS.Data
open FSharp.Data

type Rss = XmlProvider<"http://pablojuan.com/rss">

let blog = Rss.GetSample()


// Title is a property returning string 
//printfn "%s" blog.Channel.Title

// Get all item nodes and print title with link
//for item in blog.Channel.Items do
//  printfn " - %s (%s)" item.Title item.Link
