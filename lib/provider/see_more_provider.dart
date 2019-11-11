import 'package:event/models/see_more_model.dart';
import 'package:flutter/material.dart';

class SeeMoreProvider with ChangeNotifier{

   List<SeeMoreModel> _seeMoreModel=[

       SeeMoreModel("this is a  asjdhkad kjdskands askjsdjhakjs Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
       SeeMoreModel("this is a Task","1969-07-20 20:18:04Z", "Delhi", "https://images.unsplash.com/photo-1503428593586-e225b39bddfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", "https://unsplash.com/photos/RDUyi9YXPxk", "238"),
   ];

   List<SeeMoreModel> get seeMoreItems{
     return [..._seeMoreModel];
   }

}