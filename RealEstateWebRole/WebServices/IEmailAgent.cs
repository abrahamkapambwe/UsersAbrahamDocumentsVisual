using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;

// NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IEmailAgent" in both code and config file together.
//[DataContract]
//public class MessageToClient
//{
//    [DataMember]
//    public int ProductID;
//    [DataMember]
//    public string Name;
//    [DataMember]
//    public string Comment;
//}
[ServiceContract]
public interface IEmailAgent
{
    
    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json)]
    string Result(string propertyid, string userid, string name, string phone, string email, string comment, string agentid);
    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json)]
    string EmailFriend(string propertyid, string name, string email, string firstname, string firstemail, string secondname, string secondemail,string comment);
    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json)]
    void Favourite(string propertyid, string userid);
}

