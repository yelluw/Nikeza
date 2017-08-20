module Nikeza.Server.Wordpress

open System
open System.Text
open System.Net.Http
open Newtonsoft.Json
open System.IO
open System.Xml
open System.Xml.Serialization
open Nikeza.Server.DataStore
open Nikeza.Server.Models

   
let deserializeXml content =
    let root = XmlRootAttribute("rss")
    let serializer = XmlSerializer(typeof<Rss>,root)
    use reader = new StringReader(content)
    serializer.Deserialize reader :?> Rss

let rssFeed (feedUrl: string) = async { 
    let  client = new  HttpClient()
    let! response = client.GetByteArrayAsync(feedUrl) |> Async.AwaitTask   
    return  Encoding.UTF8.GetString(response,0, (response.Length - 1)) |> deserializeXml
}

//let saveFeedData data = 
    // call rssFeed here
    //pipe data to function that does query  
