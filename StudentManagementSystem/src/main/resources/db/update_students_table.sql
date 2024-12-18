-- Add created_at column to students table
ALTER TABLE students ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Update existing records to have a created_at value
UPDATE students SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;
