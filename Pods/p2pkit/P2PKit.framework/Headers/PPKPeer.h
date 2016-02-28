/**
 * PPKPeer.h
 * P2PKit
 *
 * Copyright (c) 2016 by Uepaa AG, Zürich, Switzerland.
 * All rights reserved.
 *
 * We reserve all rights in this document and in the information contained therein.
 * Reproduction, use, transmission, dissemination or disclosure of this document and/or
 * the information contained herein to third parties in part or in whole by any means
 * is strictly prohibited, unless prior written permission is obtained from Uepaa AG.
 *
 */

#import <Foundation/Foundation.h>


/*!
 *  @abstract       <b>(Beta API)</b><br/> The Proximity Strength of a peer.
 *
 *  @discussion     Proximity Ranging adds context to the discovery events by providing 5 levels of proximity strength (from “immediate” to “extremely weak”). You could associate "proximity strength" with distance, but due to the unreliable nature of signal strength (different hardware, environmental conditions, etc.) we preferred not to associate the two. Nevertheless, in many cases you will be able to determine who is the closest peer to you (if he is significantly closer than others).
 *
 *  @see            <code>PPKPeer.proximityStrength</code>
 *  @warning        Please note that the proximity strength relies on the signal strength and can be affected by various factors in the environment.
 */
typedef NS_ENUM(NSInteger, PPKProximityStrength) {

    /*! Proximity strength cannot be determined and is not known. */
    PPKProximityStrengthUnknown,
    
    /*! Proximity strength is extremely weak. */
    PPKProximityStrengthExtremelyWeak,
    
    /*! Proximity strength is weak. */
    PPKProximityStrengthWeak,
    
    /*! Proximity strength is medium. */
    PPKProximityStrengthMedium,
    
    /*! Proximity strength is strong. */
    PPKProximityStrengthStrong,
    
    /*! Proximity strength is immediate. */
    PPKProximityStrengthImmediate
};


/*!
 *  @class PPKPeer
 *
 *  @abstract <code>PPKPeer</code> represents an instance of a nearby peer.
 */
@interface PPKPeer : NSObject

/*!
 *  A unique identifier for the peer.
 */
@property (readonly) NSString *peerID;

/*!
 *  A <code>NSData</code> object containing the discovery info of the peer (can be nil if the peer does not provide a discovery info).
 */
@property (readonly) NSData *discoveryInfo;

/*!
 *  @abstract       <b>(Beta API)</b><br/> Indicates the current Proximity Strength of the peer.
 *
 *  @see            <code>PPKPeerProximityStrength</code>
 *  @warning        Please note that the proximity strength relies on the signal strength and can be affected by various factors in the environment.
 */
@property (readonly) PPKProximityStrength proximityStrength;

@end
