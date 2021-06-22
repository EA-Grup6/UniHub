import {Router} from 'express';
import {createUser, loginUser, deleteUser, getUsers,/*, getAdmin*/
updateUser, getUser, getAdmin, getUniversities, getDegrees, getSubjects, updateFollowers, getUserImage, deleteAll, getFollowers} from '../controllers/user.controller'
import { getOffer, getOffers, updateOffer, deleteOffer, createOffer, updateBuys, updateLikesOffer, getAllOffers, getOfferSubject} from '../controllers/offer.controller'
import { getFeed, getFeeds, updateFeed, deleteFeed, createFeed, updateLikesFeed, getAllFeeds } from '../controllers/feedPublication.controller'
import { createComment, deleteComment, getComments, updateComment, updateLikesComment } from '../controllers/comments.controller';

const router = Router();
    


router.route('/User/newUser/').post(createUser);
    
router.route('/User/loginUser/').post(loginUser);

router.route('/User/deleteUser/:username').delete(deleteUser);

router.route('/User/deleteAll/:username').delete(deleteAll);

router.route('/User/getUsers').get(getUsers);

router.route('/User/getUser/:username').get(getUser);

router.route('User/getAdmin/:id').get(getAdmin);

router.route('/User/getFollowers/').post(getFollowers);

//profile update
router.route('/User/updateUser').post(updateUser);

//Offer Crud
router.route('/Offer/newOffer').post(createOffer);

router.route('/Offer/deleteOffer/:id').delete(deleteOffer);

router.route('/Offer/getOffer/:username').get(getOffer);

//router.route('/Offer/getOffers').post(getOffers);

router.route('/Offer/getAllOffers').get(getAllOffers);

router.route('/Offer/updateOffer').post(updateOffer);

router.route('/Offer/getOfferSubject').post(getOfferSubject)

//Feed Crud
router.route('/Feed/newFeed').post(createFeed);

router.route('/Feed/deleteFeed/:id').delete(deleteFeed);

router.route('/Feed/getFeed/:username').get(getFeed);

router.route('/Feed/getFeeds').post(getFeeds);

router.route('/Feed/getAllFeeds').get(getAllFeeds);

router.route('/Feed/updateFeed').post(updateFeed);

router.route('/User/getUserImage/:username').get(getUserImage);

//Get Universities/Faculties/Degrees/Subjects

router.route('/Data/getUniversities').get(getUniversities);

router.route('/Data/getDegrees/:school').get(getDegrees);

router.route('/Data/getSubjects/:degree').get(getSubjects);

//Explore Feed

//Comments
router.route('/Comment/newComment/:feedId').post(createComment);

router.route('/Comment/deleteComment/:id').delete(deleteComment);

router.route('/Comment/getComments/:feedId').get(getComments);

router.route('/Comment/updateLikes/:action').post(updateLikesComment);

//Likes, Buys & following

router.route('/Feed/updateLikes/:action').post(updateLikesFeed);

router.route('/User/Offers/updateLikes').post(updateLikesOffer);

router.route('/Offer/updateBuys').post(updateBuys);

router.route('/User/updateFollowers/:action').post(updateFollowers);


//router.route('/User/loginUser/').put(loginUser); //Forgot password

export default router;