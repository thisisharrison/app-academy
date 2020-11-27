class CatRentalRequest < ApplicationRecord
    validates :start_date, :end_date, :status, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
    validate :does_not_overlap_approved_requests
    validate :future_dates_only 
    validate :start_must_come_before_end

    belongs_to :cat
    
    def approve!
        raise 'not pending' unless self.status == 'PENDING'
        
        # transaction: protective block so that only permanent if all succeed 
        transaction do 
            self.status = 'APPROVED'
            self.save!
            
            # rejecting all overlapping pending requests 
            overlapping_pending_requests.each do |req|
                req.update!(status: 'DENIED')
            end
        end
    end

    def deny!
        self.status = 'DENIED'
        self.save!
    end

    def pending?
        self.status == 'PENDING'
    end

    def denied?
        self.status == 'DENIED'
    end
    
    def overlapping_requests
        CatRentalRequest
            .where.not(id: self.id)
            .where(cat_id: cat_id)
            .where.not('start_date > :end_date OR end_date < :start_date', end_date: end_date, start_date: start_date)
            # where('cat_rental_requests.start_date BETWEEN ? AND ?', self.start_date, self.end_date)
            # overlap does not happens:
                # A starts after B ends
                # A ends before B starts
    end

    def overlapping_approved_requests
        overlapping_requests.where(status: 'APPROVED')
    end

    def overlapping_pending_requests
        overlapping_requests.where(status: 'PENDING')
    end

    def does_not_overlap_approved_requests
        # Without this line 
        # Denied requests will fail not overlap approved requests
        # Causing update to fail
        
        # When updating overlapping results to denied, 
        # it overlaps the approved requests 
        # so if not return, it will count as overlapping approved requests 
        return if self.denied?
        
        if overlapping_approved_requests.exists?
            errors[:base] << 'Request conflict'
        end
    end

    def future_dates_only
        return if start_date > DateTime.now
        errors[:start_date] << 'must be a future date'
    end

    def start_must_come_before_end
        return if start_date < end_date
        errors[:start_date] << 'must come before end date'
        errors[:end_date] << 'must come after start date'
    end



end