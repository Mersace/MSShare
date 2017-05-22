//
//  MSMeCell.m
//  MSShare
//
//  Created by Ashscar on 17/5/22.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSMeCell.h"

@implementation MSMeCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // imageView
    self.imageView.ms_y = MSSmallMargin;
    self.imageView.ms_height = self.contentView.ms_height - 2 * MSSmallMargin;
    self.imageView.ms_width = self.imageView.ms_height;
    
    // label
    self.textLabel.ms_x = self.imageView.ms_right + MSMargin;

}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
