class Global {
  private static let global = Global()
  var instagramData:InstagramData?
  class func sharedObject() -> Global{
    return Global.global
  }
}
