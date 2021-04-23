 export class Hospital {
  _id: String;
  username: String;
  description: String;
  url: String;


  constructor(_id = '', username = '', description = '',url = '') {
    this._id = _id;
    this.username = username;
    this.description = description;
    this.url = url;
  }
}