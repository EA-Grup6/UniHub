import {Router} from 'express';
import {createUser, loginUser, deleteUser, getUsers,/*, getAdmin*/
updateUser, getUser, getAdmin} from '../controllers/user.controller'
import { getOffer, getOffers, updateOffer, deleteOffer, createOffer} from '../controllers/offer.controller'
import { getFeed, getFeeds, updateFeed, deleteFeed, createFeed } from '../controllers/feedPublication.controller'

const router = Router();
    


router.route('/User/newUser/').post(createUser);
    
router.route('/User/loginUser/').post(loginUser);

router.route('/User/deleteUser/:username').delete(deleteUser);

router.route('/User/getUsers').get(getUsers);

router.route('/User/getUser/:username').get(getUser);

router.route('User/getAdmin/:id').get(getAdmin);

//profile update
router.route('/User/updateUser').post(updateUser);

//Offer Crud
router.route('/User/newOffer').post(createOffer);

router.route('/User/deleteOffer/:id').delete(deleteOffer);

router.route('/User/getOffer/:username').get(getOffer);

router.route('/User/getOffers/').post(getOffers);

router.route('/User/updateOffer').post(updateOffer);

//Feed Crud
router.route('/User/newFeed').post(createFeed);

router.route('/User/deleteFeed/:id').delete(deleteFeed);

router.route('/User/getFeed/:username').get(getFeed);

router.route('/User/getFeeds').post(getFeeds);

router.route('/User/updateFeed').post(updateFeed);

//Explore Feed


//router.route('/User/loginUser/').put(loginUser); //Forgot password

export default router;